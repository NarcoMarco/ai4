<!DOCTYPE html>
<html>
<head>
    <title>File Upload</title>
</head>
<body>
    <h2>Upload a File</h2>
    <form action="upload.php" method="post" enctype="multipart/form-data">
        Select file to upload:
        <input type="file" name="upload">
        <input type="submit" value="Upload File">
    </form>
    <?php
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $target_dir = "uploads/";
        $target_file = $target_dir . basename($_FILES["upload"]["name"]);

        // Move uploaded file to the target directory
        if (move_uploaded_file($_FILES["upload"]["tmp_name"], $target_file)) {
            echo "The file " . htmlspecialchars(basename($_FILES["upload"]["name"])) . " has been uploaded.";
        } else {
            echo "Sorry, there was an error uploading your file.";
        }
    }
    ?>
</body>
</html>
