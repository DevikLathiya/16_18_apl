<?php
    $con = mysqli_connect("localhost","id20699314_myapiapp","LathiyaDevik@1783","id20699314_api_demo") or die("DB Not Connect");
    if(isset($_POST['id']))
    {
        $id =$_POST['id'];
    }
    else return;
    if(isset($_POST['image']))
        {
            $img =$_POST['image'];
        }
        else return;
    $delete = "delete from Api_contact where id = '$id'";
    $data = mysqli_query($con,$delete);
    unlink($img);

    $arr = [];

    if($data)
    {
        $arr['result'] = "done";
    }
    else
    {
        $arr['result'] = "Not done";
    }

    echo json_encode($arr);
?>