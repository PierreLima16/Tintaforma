if (!alvo) exit;
    
image_alpha = speed / 3;

//image_blend = c_orange;
//
image_xscale = lerp(image_xscale, speed * 3, 0.1);

image_angle = direction;

if (voltar == false)
{
    speed -= 0.05;
    
    if (speed < 0)
    {
        voltar = true;
        
        
        var _x = alvo.x + random_range(-2, 2);
        var _y = alvo.y - 12 + random_range(-2, 2);
        var _dir = point_direction(x, y, _x, _y);
        direction = _dir;
    }
    
    
}
else 
{
    speed += 0.2;
    
    var _player = instance_place(x, y, obj_player);
    
    if (_player)
    {
        with(_player)
        {
            var _xscale = random_range(-0.2, 0.3);
            var _yscale = random_range(-0.2, 0.3);
            
            efeito_squash(1 + _xscale, 1 + _yscale);  
            aplica_efeito_brilho(); 
        }
        
        screenshake(2);
        
        instance_destroy();
    }
}
