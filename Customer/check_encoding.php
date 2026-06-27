<?php
$f = file_get_contents('bootstrap/app.php');
$bom = substr($f, 0, 3) === "\xEF\xBB\xBF" ? 'YES' : 'NO';
echo "BOM: $bom\n";
echo "First 200 bytes (hex): " . bin2hex(substr($f, 0, 200)) . "\n";
