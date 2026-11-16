<?php
function certificateFullName($first, $last)
{
    if (!is_string($first) || !is_string($last)) return '';
    $first = trim(preg_replace('/\s+/u', ' ', $first) ?? '');
    $last = trim(preg_replace('/\s+/u', ' ', $last) ?? '');
    if ($first === '' || $last === '' || mb_strlen($first) > 80 || mb_strlen($last) > 80) return '';
    if (preg_match('/[\x00-\x1F\x7F]/u', $first . $last)) return '';
    return $first . ' ' . $last;
}

function certificateFitName($font, $text, $size, $maxWidth)
{
    while ($size > 12) {
        $box = imagettfbbox($size, 0, $font, $text);
        if ($box && $box[2] - $box[0] <= $maxWidth) break;
        $size--;
    }
    return $size;
}
