import random
import matlab.engine


def trafficMethod():
    vd = 65.0  # %无人机的设定速度
    vt = 40.0  # %货车的设定速度
    Gdmax = 10  # %无人机载重上限
    longdmax = 2500  # %无人机航程上限
    TDrate = 1 / 25  # %无人机与货车的成本比
    eng = matlab.engine.start_matlab() # 导入matlab环境：
    f = open("sj.txt")
    line = f.readline()
    sj0 = []
    while line:
        line = line.replace("\n", "")
        line = line.split(" ")
        line = list(map(float, line))
        # print(line)
        # print(type(line))
        sj0.append(line)
        # 读下一行：
        line = f.readline()
    f.close()
    sj0 = matlab.double(sj0)
    weight = [0]  # 各包裹的重量
    for i in range(100):
        weight.append(2.3 * random.random())
    weight.append(0)
    # a重货物点序号
    a = []
    for i in range(102):
        if weight[i] >= 2.3:
            a.append(weight[i])
    weight = matlab.double(weight)
    a = matlab.double(a)

    # patht货车的路径；pathd无人机的路径；long车机协同配送成本；
    # save_ratefor0：车机协同相比货车单独配送的成本节省率
    # save_ratefor1：车机协同相比初始解的成本节约率
    patht, pathd, long, save_ratefor0, save_ratefor1 = eng.main(sj0, vd, vt, Gdmax,
                                                                longdmax, weight,
                                                                TDrate, a,
                                                                nargout=5)
    return patht,pathd,long,save_ratefor0,save_ratefor1
    # print("patht", patht)
    # print("pathd", pathd)
    # print("long", long)
    # print("losave_ratefor0ng", save_ratefor0)
    # print("lonsave_ratefor1g", save_ratefor1)




