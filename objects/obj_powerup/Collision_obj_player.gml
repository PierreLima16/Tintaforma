if (alvo == noone)
{
    //Colocando o player no estado certo
    other.estado_pega_powerup();
    
    //Definindo que é o meu alvo ( O player é meu alvo)
    alvo = other.id;
    
    //Ativando o método "movendo"
    movendo();
    
    explosao();
    
    other.powerup_tinta = true;
    
}


    