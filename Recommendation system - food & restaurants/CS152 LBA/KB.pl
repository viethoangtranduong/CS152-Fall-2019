
%  Tell prolog that known/3 will be added later by asserta
:- dynamic known/3. 

% Enter your KB below this line:

% problem(battery) :- \+engine(turning_over), battery(bad).
% battery(bad) :- lights(weak).
% battery(bad) :- radio(weak).
% problem(out_of_gas) :- engine(turning_over), gas_gauge(empty).
% problem(engine_flooded) :- engine(turning_over), smell(gas).

restaurant(the_Visit) :- price(medium), distance(near), accessibility(bicycle), cuisine(western), meal_type(cafe), (vegan_option(vegan) ; vegan_option(non_vegan)), language(english), (opening_hours(morning); opening_hours(afternoon)).
restaurant(maroush) :- price(low), distance(near), accessibility(bicycle), cuisine(middle_eastern), meal_type(snack), (vegan_option(vegan) ; vegan_option(non_vegan)), language(english), (opening_hours(afternoon); opening_hours(evening)).
restaurant(hacibaba) :- price(low), distance(near), accessibility(bicycle), cuisine(middle_eastern), meal_type(snack), (vegan_option(vegan) ; vegan_option(non_vegan)), language(english), (opening_hours(evening); opening_hours(afternoon)).
restaurant(green_Rice) :- price(medium), distance(near), accessibility(bicycle), cuisine(asian), meal_type(restaurant), (vegan_option(vegan) ; vegan_option(non_vegan)), language(english), (opening_hours(morning); opening_hours(afternoon)).
restaurant(tangs) :- price(medium), distance(near), accessibility(bicycle), cuisine(asian), meal_type(restaurant), (vegan_option(vegan) ; vegan_option(non_vegan)), language(english), (opening_hours(afternoon); opening_hours(evening)).
restaurant(zur_Gerichtslaube) :- price(high), distance(far), accessibility(bicycle), cuisine(western), meal_type(restaurant), (vegan_option(vegan) ; vegan_option(non_vegan)), language(english), opening_hours(evening).
restaurant(parker_Bowles) :- price(medium), distance(near), accessibility(bus), cuisine(western), meal_type(restaurant), vegan_option(non_vegan), language(german), (opening_hours(evening)).
restaurant(cocolo_ramen) :- price(medium), distance(far), accessibility(bus), cuisine(asian), meal_type(restaurant), vegan_option(non_vegan), language(english), (opening_hours(afternoon); opening_hours(evening)).


% The code below implements the prompting to ask the user:

price(X) :- menuask(price, X, [low, medium, high]).
distance(X) :- menuask(distance, X, [near, far]).
accessibility(X) :- menuask(accessibility, X, [bicycle, bus]).
cuisine(X) :- menuask(cuisine, X, [asian, middle_eastern, western]).
meal_type(X) :- menuask(meal_type, X, [cafe, snack, restaurant]).
vegan_option(X) :- menuask(vegan_option, X, [vegan, non_vegan]).
language(X) :- menuask(language, X, [english, german]).
opening_hours(X) :- menuask(opening_hours, X, [morning, afternoon, evening]).


% Asking clauses
multivalued(none).

menuask(A, V, MenuList):-
known(yes, A, V), % succeed if true
!.	% stop looking

menuask(A, V, MenuList):-
known(_, A, V), % fail if false
!, fail.

% If not multivalued, and already known, don't ask again for a different value.
menuask(A, V, MenuList):-
\+multivalued(A),
known(yes, A, V2),
V \== V2,
!.

menuask(A, V, MenuList):-
read_py(A,V,Y,MenuList), % get the answer
asserta(known(Y, A, V)), % remember it
Y == yes.	% succeed or fail
