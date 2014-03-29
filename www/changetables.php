<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>Change tables</title>
</head>
	
<body>
		<?php
			
			$fh = fopen("./userdata.txt", "r");
			$user = fgets($fh);
			$pass = fgets($fh);
			fclose($fh);
			
			
			
			/* // Connecting, selecting database    
			 $dbconn = pg_connect("host=web0.site.uottawa.ca port=15432 dbname=".$_POST['iuser']." user=".$_POST['iuser']." password=".$_POST['ipass'])        
			or die('Could not connect: ' . pg_last_error()); 
			
			//echo $_POST['iuser']
			
			$myFile = "./userdata.txt";
			$fh = fopen($myFile, 'a+');
			fwrite($fh, $_POST['iuser']."\n".$_POST['ipass']);
			
			pg_close($dbconn);*/
		?>
</body>
</html>
