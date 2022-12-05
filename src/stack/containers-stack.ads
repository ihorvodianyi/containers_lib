generic
   type Element_Type is private;

package Containers.Stack is

   type Stack_Interface is interface;
   function Length1 (Container : in Stack_Interface) return Count_Type is abstract;
   function Is_Empty (Container : in Stack_Interface) return Boolean is abstract;
   function Is_Full (Container : in Stack_Interface) return Boolean is abstract;

   procedure Clear (Container : in out Stack_Interface) is abstract;

   procedure Push
     (Container : in out Stack_Interface;
      New_Item  : in Element_Type;
      Success   : out Boolean) is abstract;
   
   procedure Pop
     (Container : in out Stack_Interface;
      Element   : out Element_Type;
      Success   : out Boolean) is abstract;

end Containers.Stack;
