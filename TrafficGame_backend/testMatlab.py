import matlab.engine
eng = matlab.engine.start_matlab()
ret = eng.my_sum(1.0,5.0)
print(ret)