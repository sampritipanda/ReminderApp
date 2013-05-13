<?php
	include('api/fullonsms-api.php');
	sendFullonSMS ( '9437267659' , '72310' , $_POST["number"] , "Reminder App -> " . $_POST["reminder"]);
	
	echo "<center><h1>Message sent successfully!</h1></center>"
?>