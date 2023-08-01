%CL103
clear all;
clc;

quizzes = [12, 8, 4, 7 12];
papers = [94, 96, 91, 95];
tests = [89, 95];
final_exam = 76;

%drop lowest quiz
[mn, ind] = min(quizzes);
quizzes(ind) = [];

quizzes_weighted = mean(quizzes);
papers_weighted = mean(papers(1:3))/100*15+papers(4)/100*15;
test_weighted = mean(tests)/100*40;
final_exam_weighted = final_exam/100*20;

%quizzes(min(quizzes,2)) = [];
final_grade = quizzes_weighted + test_weighted + papers_weighted + final_exam_weighted;
