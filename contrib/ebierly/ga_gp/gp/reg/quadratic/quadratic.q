/
Koza Genetic Programming p.162
simple symbolic regression
discover the "unknown" quadratic
http://books.google.com/books?id=Bhtxo60BV0EC&dq=data+minig+and+gentic+programming&printsec=frontcover&source=in&hl=en&sa=X&oi=book_result&resnum=11&ct=result#PPA162,M1
\

/ number of points for X
SAMPLE:20

\l ../reg.q

Y:{sum x xexp 4 3 2 1}each X

runModel 305

-1"";

show phenoType first exec tree from gp_bestof where hit

-1"";
-1"to see steps to the solution type the browseStep command below into your q console";
-1"requires internet connection for use of google gadget";
-1"browseStep 305";

