all : fuzzer-html fuzzer-email fuzzer-httpclient fuzzer-json

CPYTHON_LIB_PATH=$(CPYTHON_INSTALL_PATH)/lib/python3.8
CPYTHON_LIB_DYNLOAD_PATH=$(CPYTHON_LIB_PATH)/lib-dynload

DYNLOAD_LIBS=_hashlib _sha3 _blake2 _struct binascii math pyexpat _random _socket select _decimal _csv
DYNLOAD_LIBS_PATHS=$(addsuffix *.so,$(addprefix $(CPYTHON_LIB_DYNLOAD_PATH)/,$(DYNLOAD_LIBS)))

PYTHON_LD_FLAGS=$(CPYTHON_INSTALL_PATH)/lib/libpython3.8.a -lutil -lpthread $(DYNLOAD_LIBS_PATHS)

fuzzer-html:
	clang++ $(CXXFLAGS) -fsanitize=fuzzer -std=c++17 -I $(CPYTHON_INSTALL_PATH)/include/python3.8/ fuzzer.cpp -DPYTHON_HARNESS_PATH="\"html.py\"" $(PYTHON_LD_FLAGS) -ldl -o fuzzer-html
fuzzer-email:
	clang++ $(CXXFLAGS) -fsanitize=fuzzer -std=c++17 -I $(CPYTHON_INSTALL_PATH)/include/python3.8/ fuzzer.cpp -DPYTHON_HARNESS_PATH="\"email.py\"" $(PYTHON_LD_FLAGS) -ldl -o fuzzer-email
fuzzer-httpclient:
	clang++ $(CXXFLAGS) -fsanitize=fuzzer -std=c++17 -I $(CPYTHON_INSTALL_PATH)/include/python3.8/ fuzzer.cpp -DPYTHON_HARNESS_PATH="\"httpclient.py\"" $(PYTHON_LD_FLAGS) -ldl -o fuzzer-httpclient
fuzzer-json:
	clang++ $(CXXFLAGS) -fsanitize=fuzzer -std=c++17 -I $(CPYTHON_INSTALL_PATH)/include/python3.8/ fuzzer.cpp -DPYTHON_HARNESS_PATH="\"json.py\"" $(PYTHON_LD_FLAGS) -ldl -o fuzzer-json