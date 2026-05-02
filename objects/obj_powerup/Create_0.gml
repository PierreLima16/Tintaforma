alvo = noone;


movendo = function()
{
    if (!alvo) return; //Se eu estou sem alvo, o código daqui para baixo não roda
    {
        //Definindo onde o powerup vai ir
        x = alvo.x;
        y = alvo.y - 37;
    }
    
}


explosao = function()
{
    
    var _qtd = irandom_range(20, 40);
    repeat(_qtd)
    {
        var _dir = random_range(0, 359);
        
        var _speed = random_range(2, 3);
        
        var _part = instance_create_layer(x, y, "Level", obj_part_powerup);
        _part.speed = _speed;
        _part.direction = _dir;
        
        _part.alvo = alvo;
        
    }
    
    
}