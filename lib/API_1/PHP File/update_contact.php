<?php 

    $con = mysqli_connect("localhost","id20699314_myapiapp","LathiyaDevik@1783","id20699314_api_demo") or die("DB Not Connect");

    if(isset($_POST['id'])) {   $id =$_POST['id'];}else return;

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

    if(isset($_POST['change']))
    {
        $bol = $_POST['change'];
    }
    else return;

    $email = $_POST['email'];
    $password = $_POST['password'];
    $hobby = $_POST['hobby'];
    $gender = $_POST['gender'];
    $city = $_POST['city'];



    if($bol==true)
    {
        $img = ($_POST['oldimg']);
        unlink($img);
        $img = base64_decode($_POST['newimg']);
        $myimage = "F_image/image".rand(0,1000).".jpg";
        file_put_contents($myimage,$img) or die ("not upload image");
    }
    else
    {
        $myimage = ($_POST['image']);
    }

    $qry = "update Api_contact set name='$name' , contact='$contact' ,email ='$email',password='$password',hobby='$hobby',
     gender='$gender',city='$city',image='$myimage' where id = '$id'";
    $data = mysqli_query($con,$qry);
    echo $qry;
    $arr = [];

    if($data)
    {
        $arr['result'] = "Done";
    }
    else
    {
        $arr['result'] = "Not done";
    }

    echo json_encode($arr);

?>