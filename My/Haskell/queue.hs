class Queue q where
  emptyQueue :: q a
  isEmpty :: q a -> Bool
  enqueue :: a -> q a -> q a
  dequeue :: q a -> (a, q a)

data SQueue a = SQueue { front :: [a], back :: [a] }

instance Queue SQueue where
    emptyQueue = SQueue [] []

    isEmpty (SQueue [] []) = True
    isEmpty _ = False

    enqueue val (SQueue front back) = SQueue front (val:back)

    dequeue (SQueue (val:front) back) = (val, SQueue front back)
    dequeue (SQueue [] back) = dequeue $ SQueue (reverse back) []

instance Eq a => Eq (SQueue a) where
    (SQueue f1 b1) == (SQueue f2 b2) = (f1 ++ reverse b1) == (f2 ++ reverse b2)

instance Show a => Show (SQueue a) where
    show (SQueue front back) = 'q':show (front ++ reverse back)

instance Functor SQueue where
    fmap f (SQueue front back) = SQueue (fmap f front) (fmap f back)

queue_of_nums :: Queue q => Int -> Int -> q Int
queue_of_nums a b = foldl (flip enqueue) emptyQueue [a..b]