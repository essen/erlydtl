ERL=erl
ERLC=erlc

PARSER=src/erlydtl/erlydtl_parser

all: $(PARSER).erl ebin/erlydtl.app
	$(ERL) -make 

$(PARSER).erl: $(PARSER).yrl
	$(ERLC) -o src/erlydtl src/erlydtl/erlydtl_parser.yrl

ebin/erlydtl.app: src/erlydtl/erlydtl.app
	@cp -v $< $@
 
run:
	$(ERL) -pa ebin


test:
	$(ERL) -noshell -pa ebin \
		-s erlydtl_functional_tests run_tests \
		-s erlydtl_dateformat_tests run_tests \
		-s erlydtl_unittests run_tests \
		-s init stop
	
clean:
	rm -fv ebin/*.beam ebin/erlydtl.app
	rm -fv erl_crash.dump $(PARSER).erl
