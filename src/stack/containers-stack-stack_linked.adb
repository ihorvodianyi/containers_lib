with Ada.Strings;
with Ada.Strings.Text_Buffers;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
package body Containers.Stack.Stack_Linked is
   
   procedure Free(Node : in out Node_Access);

   ------------
   -- Length --
   ------------

   function Length1 (Container : in Stack) return Count_Type is
   begin
      return Container.Length;
   end Length1;
   
   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Container : in Stack) return Boolean is
   begin
      return Container.Length = 0;
   end Is_Empty;
   
   -------------
   -- Is_Full --
   -------------

   function Is_Full (Container : in Stack) return Boolean is
   begin
      return Container.Length = Container.Capacity;
   end Is_Full;
   
   -----------
   -- Clear --
   -----------

   procedure Clear (Container : in out Stack)
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
         Free(Node);
         Container.Length := Container.Length - 1;
      end loop;
   end Clear;
      
   ----------
   -- Push --
   ----------

   procedure Push
     (Container : in out Stack;
      New_Item  : in Element_Type;
      Success   : out Boolean)
   is
      New_Node : Node_Access;
   begin
      if Container.Length < Container.Capacity
      then
         New_Node := new Node_Type'(New_Item, Container.Head);
         Container.Head := New_Node;
         Container.Length := Container.Length + 1;
         Success := True;
      else
         Success := False;
      end if;                  
   end Push;
   
   ---------
   -- Pop --
   ---------

   procedure Pop
     (Container : in out Stack;
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
   end Pop;
      
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
      Container : in Stack)
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

   procedure Initialize(Container : in out Stack)
   is
   begin
      Put_Line("Initialize: " & Container'Image);
   end Initialize;
   
   ------------
   -- Adjust --
   ------------

   procedure Adjust(Container : in out Stack)
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

   procedure Finalize(Container : in out Stack)
   is
   begin
      Clear(Container);
   end Finalize;

end Containers.Stack.Stack_Linked;
