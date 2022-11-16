with Containers.Stack_Interface;
with Ada.Finalization;

private with Ada.Streams;
private with Ada.Strings.Text_Buffers;

generic
   type Element_Type is private;

package Containers.Stack_Linked is
   
   type Stack (Capacity : Count_Type) is private;
   
   function Length (Container : in Stack) return Count_Type;
   
   function Is_Empty (Container : in Stack) return Boolean;
   
   procedure Clear (Container : in out Stack);
   
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
   
   type Node_Type is
   limited record
      Element : aliased Element_Type;
      Next    : Node_Access;
   end record;
   
   type Stack (Capacity : Count_Type) is new Ada.Finalization.Controlled with
      record
         Head           : Node_Access:= null;
         Length         : Count_Type := 0;
      end record with Put_Image => Put_Image;
   
   procedure Put_Image
     (Stream : in out Ada.Strings.Text_Buffers.Root_Buffer_Type'Class;
      Container : in Stack);
   
   procedure Initialize(Container : in out Stack);
   procedure Adjust(Container : in out Stack);
   procedure Finalize(Container : in out Stack);
   

end Containers.Stack_Linked;
