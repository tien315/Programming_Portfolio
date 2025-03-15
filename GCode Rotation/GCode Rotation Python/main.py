import pandas as pd
import numpy as np
import math


# Functions
def is_movement(g_string, move_type):
    if move_type == "all movement":
        check_list = ["G00", "G0", "G01", "G1", "G02", "G2", "G03", "G3"]
    elif move_type == "circular movement":
        check_list = ["G02", "G03", "G2", "G3"]
    else:
        check_list = [0]
    movement = False
    for i_loc in range(len(check_list)):
        if check_list[i_loc] == g_string:
            movement = True
            break
    return movement


def find_coord(x, y, index):
    coord = [find_exp(x, index), find_exp(y, index)]
    return coord


def find_new_center(st_coord, ed_coord, u_val, iteration):
    # Find distance between start and end points

    d = math.sqrt(math.pow(ed_coord[0] - st_coord[0], 2) + math.pow(ed_coord[1] - st_coord[1], 2))
    # Keep d / 2 < U when rounding error occurs(ex.d = 0.6066, U = 0.3033 when rounded to 3 decimals, d = 0.607 and
    # U = 0.303.The line below turns d into 0.606 instead by truncation.)
    d = math.floor((d * 1000)) / 1000
    print(d)
    print(u_val)
    # Check the distance between the start and end are not more than the specified radius.
    if d/2 > abs(u_val):
        print(f"Error, distance between start and end points is greater than the radius specified. Please check "
              f"line " + str(iteration))
        return

    x = d / 2
    y = math.sqrt(math.pow(u_val, 2) - math.pow(d / 2, 2))
    # avoid domain error, div by 0
    theta = math.atan((ed_coord[1] - st_coord[1]) / (ed_coord[0] - st_coord[0] + 0.0000000000000001))

    if ed_coord[0] < st_coord[0]:
        theta = theta + math.pi
    # Transformation matrix
    q_rot = np.array([[math.cos(theta), -math.sin(theta)], [math.sin(theta), math.cos(theta)]])

    # U values < 0 indicate an arc tracing > 180 degrees, so we need to flip the center used.
    if u_val < 0:
        G2 = q_rot @ np.array([[x], [y]])
        G3 = q_rot @ np.array([[x], [-y]])
    else:
        G2 = q_rot @ np.array([[x], [-y]])
        G3 = q_rot @ np.array([[x], [y]])

    n_center = np.array([[round(G2[0, 0], 3), round(G2[1, 0], 3)],
                        [round(G3[0, 0], 3), round(G3[1, 0], 3)]])
    print(n_center)
    return n_center


def find_exp(vec, index):

    temp = vec[index]
    temp = temp[1:-1]
    temp = float(temp)
    return temp


nameFileIn = input("Enter the name of the file you want to modify: ")
# f = open(nameFileIn, 'r', encoding="utf-8")
# text = f.read()
# f.close()
origin_p = pd.array([0, 0])
origin_p[0] = input("Enter the X coordinate of the center of rotation: ")
origin_p[1] = input("Enter the Y coordinate of the center of rotation: ")
user_rotation = input("Enter the rotation in degrees: ")

data = pd.read_csv(nameFileIn, sep=" ", header=None, names=["G", "X", "Y", "U", "F"])

for i in range(len(data.G)):
    if is_movement(data.G[i], "circular movement"):

        new_center = find_new_center(start_coord, end_coord, find_exp(data.U, i), i)
        if is_movement(data.G[i], "CCW"):
            # data.loc["U", i] = str(f"I" + str(new_center[0, 0]))
            # data.loc["F", i] = str(f"J" + str(new_center[1, 0]))
            data.U[i] = str(f"I" + str(new_center[1, 0]))
            data.F[i] = str(f"J" + str(new_center[1, 1]))
        else:
            # data.loc["U", i] = str(f"I" + str(new_center[0, 1]))
            # data.loc["F", i] = str(f"J" + str(new_center[1, 1]))
            data.U[i] = str(f"I" + str(new_center[0, 0]))
            data.F[i] = str(f"J" + str(new_center[0, 1]))
newFileName = nameFileIn[0:len(nameFileIn)-3]+"_modified.nc"
data.to_csv(newFileName, sep=" ", encoding='utf-8', index=False, header=False)