:: subject and formula
|=  [subject=* formula=*]
=<
^-  (unit *)
(run-nock subject formula)
|%
++  run-nock
  |=  [subject=* formula=*]
  ^-  (unit *)
  ?+  formula  ~
  ::
      :: *[s [f g] h] -> [*[s f g] *[s h]]
      [head=^ tail=*]
    =/  head=(unit *)  (run-nock subject head.formula)
    ?~  head  ~
    =/  tail=(unit *)  (run-nock subject tail.formula)
    ?~  tail  ~
    [~ (need head) (need tail)]
  ::
      :: [s 0 f] -> /[f s]
      [%0 f=@]
    =/  n=(unit)  (frag f.formula subject)
    ?~  n  ~  [~ u.n]
  ::
      :: *[s 1 f] -> f
      [%1 f=*]
    [~ f.formula]
  ::
      :: *[s 2 f g] -> *[*[s f] *[s g]]
      [%2 f=* g=*]
    =/  l=(unit *)  (run-nock subject f.formula)
    ?~  l  ~
    =/  r=(unit *)  (run-nock subject g.formula)
    ?~  r  ~
    (run-nock (need l) (need r))
  ::
      :: *[s 3 f] -> ?*[s f]
      [%3 f=*]
    =/  subject=(unit *)  (run-nock subject f.formula)
    ?~  subject  ~
    [~ ?^((need subject) 0 1)]
  ::
      :: *[s 4 f] -> +*[s f]
      [%4 f=*]
    =/  subject=(unit *)  (run-nock subject f.formula)
    ?~  subject  ~
    =/  n=*  (need subject)
    ?^  n  ~
    [~ (add n 1)]
  ::
      :: *[s 5 f g] -> =[*[s f] *[s g]]
      [%5 f=* g=*]
    =/  l=(unit *)  (run-nock subject f.formula)
    ?~  l  ~
    =/  r=(unit *)  (run-nock subject g.formula)
    ?~  r  ~
    [~ ?:(=((need l) (need r)) 0 1)]
  ::
      :: *[s 6 f g h] -> *[s *[[g h] 0 *[[2 3] 0 *[s 4 4 f]]]]
      [%6 f=* g=* h=*]
    =/  condition=(unit *)  (run-nock subject f.formula)
    ?~  condition  ~
    ?+  (need condition)  ~
        %0  (run-nock subject g.formula)
        %1  (run-nock subject h.formula)
    ==
  ::
      :: *[s 7 f g] -> *[*[s f] g]
      [%7 f=* g=*]
    =/  first=(unit *)  (run-nock subject f.formula)
    ?~  first  ~
    (run-nock (need first) g.formula)
  ::
      :: *[s 8 f g] -> *[[*[s f] s] g]
      [%8 f=* g=*]
      =/  pinned=(unit *)  (run-nock subject f.formula)
      ?~  pinned  ~
      (run-nock [(need pinned) subject] g.formula)
  ::
      :: *[s 9 a f] -> *[*[s f] 2 [0 1] 0 a]
      [%9 a=* f=*]
    =/  first=(unit *)  (run-nock subject f.formula)
    ?~  first  ~
    (run-nock (need first) [2 [0 1] 0 a.formula])
  ::
      :: *[s 10 [f g] h] -> #[f *[s g] *[s h]]
      [%10 f=* g=* h=*]
    =/  first=(unit *)  (run-nock subject g.formula)
    ?~  first  ~
    =/  second=(unit *)  (run-nock subject h.formula)
    ?~  second  ~
    [~ f.formula (need first) (need second)]
  ::
      :: *[s 11 [f g] h] -> *[[*[s g] *[s h]] 0 3]
      [%11 [f=* g=*] h=*]
    =/  first=(unit *)  (run-nock subject g.formula)
    ?~  first  ~
    =/  second=(unit *)  (run-nock subject h.formula)
    ?~  second  ~
    (run-nock [(need first) (need second)] [0 3])
  ::
      :: *[s 11 f g] -> *[s g]
      [%11 f=* g=*]
    =/  first=(unit *)  (run-nock subject g.formula)
    ?~  first  ~
    (run-nock (need first) [0 3])
  ::
  ==
++  frag
  |=  [axis=@ noun=*]
  ^-  (unit)
  ?:  =(0 axis)  ~
  |-  ^-  (unit)
  ?:  =(1 axis)  `noun
  ?@  noun  ~
  =/  pick  (cap axis)
  %=  $
    axis  (mas axis)
    noun  ?-(pick %2 -.noun, %3 +.noun)
  ==
--
