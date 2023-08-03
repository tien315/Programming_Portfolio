%
while true
    first_user_input = input('Enter a number between 1 and 50: ');
    if(first_user_input>0)&(first_user_input<51)
        break;
    else
        disp("Invalid input, try again.");
        continue;
    end
end
while true
    second_user_input = input('Enter a number between 51 and 100: ');
    if(second_user_input>50)&(second_user_input<=100)
        break;
    else
        disp("Invalid input, try again.");
        continue;
    end
end
for i = second_user_input:-2:first_user_input
    disp(i);
end
if(rem(second_user_input-first_user_input,2)~=0)
    disp(first_user_input);
end