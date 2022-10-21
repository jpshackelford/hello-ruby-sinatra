RUBY_FLAVOR = head-wasm32-unknown-wasi-full
BINARY = hello-ruby-rest.wasm
BUILD_DIR := ./build

.PHONY: build
build: ${BUILD_DIR}/$(RUBY_FLAVOR) ${BUILD_DIR}/.gem
	mkdir -p ${BUILD_DIR}
	wasi-vfs pack ${BUILD_DIR}/$(RUBY_FLAVOR)/usr/local/bin/ruby \
		--mapdir /.gem::${BUILD_DIR}/.gem \
		--mapdir /usr::${BUILD_DIR}/$(RUBY_FLAVOR)/usr \
		--mapdir /lib::./lib \
		--mapdir /::./root-dir \
		-o ${BUILD_DIR}/$(BINARY)

${BUILD_DIR}/$(RUBY_FLAVOR):
	mkdir -p ${BUILD_DIR}
	cd ${BUILD_DIR} && curl -fsLO https://github.com/ruby/ruby.wasm/releases/download/ruby-head-wasm-wasi-0.3.0/ruby-$(RUBY_FLAVOR).tar.gz
	cd ${BUILD_DIR} && tar -xf ruby-$(RUBY_FLAVOR).tar.gz

${BUILD_DIR}/.gem:
	GEM_HOME=${BUILD_DIR}/.gem bundle install

.PHONY: clean
clean:
	rm -rf ${BUILD_DIR}

.PHONY: serve
serve: ${BUILD_DIR}/$(RUBY_FLAVOR) ${BUILD_DIR}/.gem
	RUST_LOG=spin=info,wagi=info spin up --file spin.toml
