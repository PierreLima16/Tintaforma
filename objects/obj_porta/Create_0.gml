estado = "fechada";

//ps_porta_abrindo
ps = part_system_create();
part_system_draw_order(ps, true);

//Emitter
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_square);
part_type_size(ptype1, 0.5, 0.5, 0.01, 0);
part_type_scale(ptype1, 0.1, 0.1);
part_type_speed(ptype1, 0.1, 0.1, 0.01, 0);
part_type_direction(ptype1, 90, 92, 0, 0);
part_type_gravity(ptype1, 0, 270);
part_type_orientation(ptype1, 0, 0, 0, 0, false);
part_type_colour3(ptype1, $FFFFFF, $4C4C4C, $000000);
part_type_alpha3(ptype1, 0.212, 1, 0);
part_type_blend(ptype1, true);
part_type_life(ptype1, 20, 40);



maquina_de_estado = function()
{
   switch(estado)
    {
        //estado da porta fechada
        case "fechada":
        {
            
        }
        break;
    
        //estado da porta aberta
        case "abrindo":
        {
            //if (!part_system_exists(ps))
            //{
                //ps = part_system_create(ps_porta_abrindo);
                //part_system_position(ps, x, y - sprite_height / 2);
            //}
            
            //Criando minha particula manualmente
            var _x = x + random_range(-sprite_width / 1.5, sprite_width / 1.5);
            part_particles_create(ps, _x, ystart - sprite_height, ptype1, 1);
            
            
            screenshake(3);
            
            x = xstart + random_range(-1, 1);
            
            if (y >= ystart - 33)
            {
                vspeed = -0.3;
            }
            
            else 
            {
                estado = "aberta";
                
                alarm[0] = FPS;
            }
            
        }
        break; 
    
        //estado final da porta
        case "aberta":
        {
            vspeed = 0;
            
            x = xstart;
            
            
        }
        break;
    }
        
    
}

