with Ada.Finalization;

private with Ada.Streams;
private with Ada.Strings.Text_Buffers;

generic
   type Element_Type is private;

package Containers.Queue_Linked is

   type Queue (Capacity : Count_Type) is private;
   
   procedure Enqueue
     (Container : in out Queue;
      New_Item  : in Element_Type;
      Success   : out Boolean);
   
   procedure Dequeue
     (Container : in out Queue;
      Element   : out Element_Type;
      Success   : out Boolean);
   
private   

   type Node_Type;
   type Node_Access is access Node_Type;

   type Node_Type is
   limited record
      Element : aliased Element_Type;
      Next    : Node_Access;
      --  Prev    : Node_Access;
   end record;
   
   type Queue (Capacity : Count_Type) is new Ada.Finalization.Controlled with
      record
         Head   : Node_Access := null;
         Tail   : Node_Access := null;
         Length : Count_Type  := 0;
      end record with Put_Image => Put_Image;
   

   procedure Put_Image
     (Stream    : in out Ada.Strings.Text_Buffers.Root_Buffer_Type'Class;
      Container : in     Queue);

   procedure Initialize (Container : in out Queue);
   procedure Adjust (Container : in out Queue);
   procedure Finalize (Container : in out Queue);

end Containers.Queue_Linked;
