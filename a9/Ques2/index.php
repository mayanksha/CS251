<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="./script.js"></script>
			<style>
				.error {
						color: #990000;
						size : 0.6em;
				}
			</style>
	</head>
<body>

<?php 
?>
<h1>Bank Account Registration</h1>

	<a href="./seeall.php" >See all Reg</a>
	<form id="contact" name="contact" onsubmit="return validateFormOnSubmit(this)" action="index.php"  method="post">
		<div>
			<label>First Name</label>
			<input placeholder="First Name" type="text" name="name" id="name" tabindex="1" autofocus />
			<div id="name-error" class="error"></div>
		</div>
		<div>
			<label>Address</label>
			<input placeholder="Address Name" type="text" name="add" id="add" tabindex="1" autofocus />
			<div id="add-error" class="error"></div>
		</div>
		<!--<div>
		   -    <label>Nickname</label>
		   -    <input placeholder="Nickname" type="text" name="nickname" id="nickname" tabindex="2" autofocus />
		   -</div>-->
		<div>
			<label>Email</label>
			<input placeholder="Email" type="email" name="email" id="email" tabindex="3" autofocus />
			<div id="email-error" class="error"></div>
		</div>
		<div>
			<label>Phone</label>
			<input placeholder="Phone" type="tel" name="phone" id="phone" tabindex="4" autofocus />
			<div id="phone-error" class="error"></div>
		</div>
		<div>
			<label>Bank Account Number</label>
			<input placeholder="Bank A/C"  name="ac" id="ac" tabindex="4" autofocus />
			<div id="ac-error" class="error"></div>
		</div>
			<div>
				<label>Password</label>
		  <input placeholder="Password" type="password" name="pass" id="pass" tabindex="4" autofocus />
			<div id="pass-error" class="error"></div>
			</div>
		<div>
			<button type="submit" name="submit" id="submit" tabindex="10">Submit</button>
		</div>
	</form>

	<hr>
	<h2> PHP Data <h2>
	<?php 
	class MyDB extends SQLite3 {
		function __construct() {
			$this->open('data.db');
		}
	}
	$db = new MyDB();
	if(!$db) {
		echo $db->lastErrorMsg();
} $dbh = null;
if	(isset($_POST['submit'])){
	$name = $_POST['name'];
	$add = $_POST['add'];
	$email = $_POST['email'];
	$phone = $_POST['phone'];
	$ac = $_POST['ac'];
	$pass = password_hash($_POST['pass'], PASSWORD_DEFAULT);
	$ret_val = $db->querySingle("select count(*) from Bank_details where email == '$email'");
	if($ret_val != 0){
		echo "User already exists";
	}
	else {
		$ret = $db->exec("INSERT into bank_details values ('$email', '$name', '$add', '$phone', '$ac', '$pass');");
		if(!$ret) {
			echo $db->lastErrorMsg();
		} else {
			echo "Records created successfully\n";
		}
	}
}
$db->close();
?>
</body>
</html>
