with Ada.Unchecked_Deallocation;

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
         
         Container.Length := @ + 1;
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
         Container.Length := @ - 1;
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
         Container.Length := @ - 1;
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
   
   --------------
   -- Finalize --
   --------------

   procedure Finalize(Container : in out Queue)
   is
   begin
      Clear(Container);
   end Finalize;

end Containers.Queue_Linked;
