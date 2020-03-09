echo Each section is a test first line is expected then
echo  next line is what was calculated
echo "########################################"
echo TEST 1:
cat test1.c
echo  nothing
./lisp < test1.c
echo "########################################"
