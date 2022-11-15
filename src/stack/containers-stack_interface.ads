generic
   type Element_Type is private;

package Containers.Stack_Interface is
   pragma Pure;
   
   type Stack is interface;
   
   procedure Push
     (Container : in out Stack;
      New_Item  : in Element_Type;
      Success   : out Boolean) is abstract;
   
   procedure Pop
     (Container : in out Stack;
      Element   : out Element_Type;
      Success   : out Boolean) is abstract;
      
   
end Containers.Stack_Interface;
