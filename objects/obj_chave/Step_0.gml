if (colidi_com_player == true)
{
    image_xscale = lerp(image_xscale, 1.5, 0.4);
    image_yscale = lerp(image_yscale, 1.5, 0.4);
    image_alpha  = lerp(image_alpha, 0, 0.4);
}


if (image_alpha <= 0.1)
{
    instance_destroy();
}