<?php 

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

function DBConnection(){
	return new PDO('mysql:dbhost=localhost;dbname=amsosv2','root','');
}

$app = new \Slim\App([
	'settings' => [
        'displayErrorDetails' => true
    ]
]);

$app->get('/', function ($req, $res, $args) {
	$data = array('key' => 'Hello World');
    return $res->withStatus(200)->withJson($data);
});

$app->get('/ver/{id}', function($req, $res, $args){
	$route = $req->getAttribute('route');
	$id = $route->getArgument('id');

	$db = DBConnection();
	$query = $db->query("select v.*, p.msg, p.postdate, u.uid, u.nid, u.fullname, u.status 
		from version v 
		left join postings p on v.id = p.id
		left join users u on u.uid = p.uid
		where ver > ".$id." Order by ver");
	$result = $query->fetchAll(PDO::FETCH_OBJ);

	return $res->withStatus(200)->withJson($result);
});

$app->post('/msg', function($req, $res, $args){

	if($req->isPost()){
		$post = $req->getParsedBody();
		$uid = $post['uid'];
		$msg = $post['msg'];
		$out = array();

		$db = DBConnection();
		$db->beginTransaction();
		try{
			// query 1: insert to postings
			$query = "insert into postings(uid, msg, postdate, ipaddr)
	            values (:uid, :msg, :postdate, :ipaddr)";
			$stmt = $db->prepare($query);
			$stmt->bindParam(':uid', $uid);
			$stmt->bindParam(':msg', $msg);
			$stmt->bindParam(':postdate', date('c'));
			$stmt->bindParam(':ipaddr', $_SERVER['REMOTE_ADDR']);
			$stmt->execute();

			$id = $db->lastInsertId();

			// query 2: insert to version
			$db->query("insert into version(id, type, changedate, ipaddr)
	            values($id,'add','".date('c')."','".$_SERVER['REMOTE_ADDR']."')");

			$out['status'] = true;
			$out['msg'] = "post data sucess!";

			$db->commit();

		}catch(Exception $e){
			$out['status'] = false;
			$out['msg'] = $e->getMessage();

			$db->rollBack();
		}

		return $res->withStatus(200)->withJson($out);
	}

});

$app->delete('/msg/{id}', function($req, $res, $args){
	if($req->isDelete()){
		$route = $req->getAttribute('route');
		$id = $route->getArgument('id');
		$out = array();

		$db = DBConnection();
		$db->beginTransaction();
		try{

			// query delete post
			$del = $db->prepare('delete from postings where id = '.$id);
			$del->execute();

			$count = $del->rowCount();

			// query insert to version
			if($count>0){
				$db->query("insert into version(id, type, changedate, ipaddr)
		            values($id,'delete','".date('c')."','".$_SERVER['REMOTE_ADDR']."')");
			}

			$db->commit();

			$out['status'] = true;
			$out['msg'] = "delete data sucess!";

		}catch(Exception $e){
			$out['status'] = false;
			$out['msg'] = $e->getMessage();

			$db->rollBack();
		}	

		return $res->withStatus(200)->withJson($out);
	}	
});	

$app->put('/msg/{id}', function($req, $res, $args){
	if($req->isPut()){
		$route = $req->getAttribute('route');
		$id = $route->getArgument('id');
		$out = array();

		$put = $req->getParsedBody();
		$msg = $put['msg'];

		$db = DBConnection();
		$db->beginTransaction();
		try{

			// query update post
			$del = $db->prepare("update postings set msg = '".$msg."' where id = ".$id);
			$del->execute();

			$count = $del->rowCount();

			// query insert to version
			if($count>0){
				$db->query("insert into version(id, type, changedate, ipaddr)
		            values($id,'update','".date('c')."','".$_SERVER['REMOTE_ADDR']."')");
			}

			$db->commit();

			$out['status'] = true;
			$out['msg'] = "update data sucess!";

		}catch(Exception $e){
			$out['status'] = false;
			$out['msg'] = $e->getMessage();

			$db->rollBack();
		}

		return $res->withStatus(200)->withJson($out);
	}	
});	

$app->post('/auth', function($req, $res, $args){

	if($req->isPost()){
		$post = $req->getParsedBody();
		$nid = $post['nid'];
		$pwd = md5($post['pwd']);
		$out = array();

		$db = DBConnection();
		$query = $db->query("select uid,fullname,version,status,logdate from users 
			where nid = '".$nid."' and pass = '".$pwd."'");

		$result = $query->fetch(PDO::FETCH_OBJ);
		if($result){
			$out['status'] = true;
			$out['msg'] = "Login success!";
			$out['user'] = $result;
		}else{
			$out['status'] = false;
			$out['msg'] = "NIP or Password incorrect!";
		}

		return $res->withStatus(200)->withJson($out);
	}	

});

$app->run();