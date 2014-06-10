module Purugin
    module Extensions
        
        def is_axe?(itemstack)
            !![:wood_axe,:stone_axe,:iron_axe,:gold_axe,:diamond_axe].find{|material| itemstack.is? material}
        end

        def changeToStairs(block, material, dir)
            d = case dir.toString
                when "WEST" then 1
                when "EAST" then 0
                when "NORTH" then 3
                when "SOUTH" then 2
            end
            block.setTypeIdAndData(material.id, d , false);
        end

       def changeToTorch(block, dir)
            d = case dir.toString
                when "WEST" 
                    1               
                when "EAST"
                    2 
                when "NORTH" 
                    3               
                when "SOUTH"
                    4
            end
            block.setTypeIdAndData(:torch.to_material.id, d , false);
        end  
#
#        module_function :"is_axe?"
    end
end
