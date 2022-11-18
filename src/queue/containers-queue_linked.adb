with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;

package body Containers.Queue_Linked is
   
   procedure Free(Node : in out Node_Access);
   
   ------------
   -- Length --
   ------------

   function Length (Container : in Queue) return Count_Type is
   begin
      return Container.Length;
   end Length;
   
   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Container : in Queue) return Boolean is
   begin
      return Container.Length = 0;
   end Is_Empty;
   
   -------------
   -- Is_Full --
   -------------

   function Is_Full (Container : in Queue) return Boolean is
   begin
      return Container.Length = Container.Capacity;
   end Is_Full;
   
   -------------
   -- Enqueue --
   -------------

   procedure Enqueue
     (Container : in out Queue;
      New_Item  : in Element_Type;
      Success   : out Boolean)
   is
      New_Node : Node_Access;
   begin
      if Container.Length < Container.Capacity
      then
         New_Node := new Node_Type'(New_Item, null);
         if Container.Head = null then
            Container.Head := New_Node;
            Container.Tail := Container.Head;
         else
            Container.Tail.Next := New_Node;
            Container.Tail := New_Node;
         end if;
         
         Container.Length := Container.Length + 1;
         Success := True;
      else
         Success := False;
      end if;
   end Enqueue;
   
   -------------
   -- Dequeue --
   -------------

   procedure Dequeue
     (Container : in out Queue;
      Element   : out Element_Type;
      Success   : out Boolean)
   is
      Node : Node_Access;
   begin
      if Container.Length = 0 then
         Success := False;
      else
         Node := Container.Head;
         Container.Head := Container.Head.Next;
         Element := Node.Element;
         Free(Node);
         Container.Length := Container.Length - 1;
         Success := True;
      end if;
   end Dequeue;
   
   -----------
   -- Clear --
   -----------

   procedure Clear (Container : in out Queue)
   is
      Node : Node_Access;
   begin
      if Container.Length = 0 then
         return;
      end if;
      
      while Container.Length > 0
      loop
         Node := Container.Head;
         Container.Head := Container.Head.Next;
         Container.Length := Container.Length - 1;
         Free(Node);         
      end loop;
   end Clear;
   
   ----------
   -- Free --
   ----------

   procedure Free(Node : in out Node_Access) is
      procedure Deallocate is
        new Ada.Unchecked_Deallocation (Node_Type, Node_Access);

   begin
      Node.Next := Node;
      Deallocate(Node);
   end Free;

   ---------------
   -- Put_Image --
   ---------------

   procedure Put_Image
     (Stream : in out Ada.Strings.Text_Buffers.Root_Buffer_Type'Class;
      Container : in Queue)
   is
      Node   : Node_Access := Container.Head;
   begin
      Stream.Put("{Capacity: " & Container.Capacity'Image & " | Length: " & Container.Length'Image & " | Head: " & Container.Head'Image & " [");    
      while Node /= null
      loop
         Element_Type'Put_Image(Stream, Node.Element);
         Node := Node.Next;
      end loop;      
      Stream.Put("]}");
   end Put_Image;
   
   ----------------
   -- Initialize --
   ----------------

   procedure Initialize(Container : in out Queue)
   is
   begin
      Put_Line("Initialize: " & Container'Image);
   end Initialize;
   
   ------------
   -- Adjust --
   ------------

   procedure Adjust(Container : in out Queue)
   is
      Source : Node_Access := Container.Head;
      Node   : Node_Access;
   begin
      if Source = null then
         return;
      end if;
      
      Container.Head := new Node_Type'(Source.Element, null);
      Container.Length := 1;
      Node := Container.Head;
      Source := Source.Next;
      
      while Source /= null
      loop
         Node.Next := new Node_Type'(Source.Element, null);
         Node := Node.Next;
         Container.Length := @ + 1;
         Source := Source.Next;
      end loop;
   end Adjust;
   
   --------------
   -- Finalize --
   --------------

   procedure Finalize(Container : in out Queue)
   is
   begin
      Clear(Container);
   end Finalize;

end Containers.Queue_Linked;
