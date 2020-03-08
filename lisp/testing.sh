echo Each section is a test first line is expected then
echo  next line is what was calculated
echo "########################################"
echo TEST 1:
cat test1.txt
echo  4
./lisp < test1.txt
echo "########################################"
echo TEST 2:
cat test2.txt
echo  0.54534897536981641
./lisp < test2.txt
echo "########################################"
echo TEST 3:
cat test3.txt
echo  -0.3333333333333
./lisp < test3.txt
echo "########################################"
