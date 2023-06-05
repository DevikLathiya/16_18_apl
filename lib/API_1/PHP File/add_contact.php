<?php
    $con = mysqli_connect("localhost","id20699314_myapiapp","LathiyaDevik@1783","id20699314_api_demo") 
    or die("DB Not Connect");// server , username ,pass , dbName

    if(isset($_POST['name']))
    {
        $name =$_POST['name'];
    }
    else return;

    if(isset($_POST['contact']))
    {
        $contact =$_POST['contact'];
    }
    else return;

    $email = $_POST['email'];
    $password = $_POST['password'];
    $hobby = $_POST['hobby'];
    $gender = $_POST['gender'];
    $city = $_POST['city'];

    $img = base64_decode($_POST['image']);   // decord dart page encord file
    $myimage = "F_image/image".rand(0,1000).".jpg";  // set image name
    file_put_contents($myimage,$img) or die ("not upload image"); // for upload on db 

    $qry = "insert into Api_contact values(null,'$name','$contact','$email','$password','$hobby','$gender','$city','$myimage')";
    $cnt = mysqli_query($con,$qry);

    if($cnt==1){
        echo "Contact Added..";
    }else{
        echo "not Added";
    }
    //<!-- 000webhost ----site -->
?>   