<?php
define('DUPLIFICATION_FACTOR', 2);
define('SOME_OTHER_CONSTANT', 3);

// duplicates a number
function duplicate($n)
{
  return $n * DUPLIFICATION_FACTOR;
}

$valueToDuplicate = 5 + 2 * SOME_OTHER_CONSTANT;
echo duplicate($valueToDuplicate);
