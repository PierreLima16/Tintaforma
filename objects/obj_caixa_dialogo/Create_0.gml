 texto = "goku"

scribble_anim_wave(0.6, 0.8, 0.2);

escrevedor = scribble_typist();
escrevedor.in(1.2, 10)

desenhar_texto = false;

me_destruir = false;

image_xscale = 0;
image_alpha  = 0.1;

inicializando = function()
{
    image_xscale = lerp(image_xscale, 2.5, 0.1);
    image_yscale = lerp(image_yscale, 1, 0.2);
    image_alpha  = lerp(image_alpha, 0.8, 0.1);
    
    y = lerp(y, ystart - 30, 0.2)
    
    if (y <= ystart - 25)
    {
        desenhar_texto = true;
    }
}

finalizando = function()
{
        
    if (me_destruir == true)
    {
        image_xscale = lerp(image_xscale, 0, 0.1);
        
        image_yscale = lerp(image_yscale, 0, 0.1);
        
        y            = lerp(y, ystart, 0.2);
        
        image_alpha  = lerp(image_alpha, 0, 0.1);
        
        desenhar_texto = false;
        
        if (image_alpha <= 0.1)
        {
            instance_destroy();
           
        }
            
    }
}