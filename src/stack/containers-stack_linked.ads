with Containers.Stack_Interface;

generic
   type Element_Type is private;

package Containers.Stack_Linked is
   
   type Stack (Capacity : Count_Type) is private;
   
   function Length (Container : in Stack) return Count_Type;
   
   function Is_Empty (Container : in Stack) return Boolean;
   
   procedure Push
     (Container : in out Stack;
      New_Item  : in Element_Type;
      Success   : out Boolean);
   
   procedure Pop
     (Container : in out Stack;
      Element   : out Element_Type;
      Success   : out Boolean);
   
private
   
   type Node_Type;
   type Node_Access is access Node_Type;
   
   type Node_Type is limited record
      Element : aliased Element_Type;
      Next    : Node_Access;
   end record;
   
   type Stack (Capacity : Count_Type) is record
      Head     : Node_Access:= null;
      Length   : Count_Type := 0;
   end record;
   

end Containers.Stack_Linked;
