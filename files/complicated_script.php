#!/usr/bin/php
<?php
function fibonacci($n)
{
  if ($n <= 1) {
    return $n;
  }
  else {
    return fibonacci($n - 1) + fibonacci($n - 2);
  }
}

$valueToCompute = 10;
echo fibonacci($valueToCompute);
