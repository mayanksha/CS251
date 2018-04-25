<!DOCTYPE html>
<html>
<body>

	<h2>Admin Panel</h2>
	<form id="admin" name="admin" onsubmit="" action="seeall.php"  method="post">
		<div>
			<label>Email</label>
			<input placeholder="Email" type="email" name="email" id="email" tabindex="3" autofocus />
			<div id="email-error" class="error"></div>
		</div>
		<div>
			<label>Password</label>
	  <input placeholder="Password" type="password" name="pass" id="pass" tabindex="4" autofocus />
		<div id="pass-error" class="error"></div>
		</div>

		<div>
			<button type="submit" name="submit" id="submit" tabindex="10">Submit</button>
		</div>
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
}
else {
	echo "DB Opened";
}
$dbh = null;
if	(isset($_POST['submit'])){
	$que = "Select * from Bank_details";
	$result = $db->query($que);
	echo "<table border='1'>
		<tr>
		<th>Name</th>
		<th>Email</th>
		<th>Address</th>
		<th>Phone</th>
		</tr>";
	while($row = $result->fetchArray())
	{
		echo "<tr>";
		echo "<td>" . $row['name'] . "</td>";
		echo "<td>" . $row['email'] . "</td>";
		echo "<td>" . $row['address'] . "</td>";
		echo "<td>" . $row['phone'] . "</td>";
		echo "</tr>";
	}
	echo "</table>";
}
?>
</body>
</html>
