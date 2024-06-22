.DEFAULT_GOAL := help

.PHONY: license

# Function to add license to the head of a file - Credit: GPT-4
define add_license
	@file_path=$(file); \
	extension=$$(echo $$file_path | awk -F . '{print $$NF}'); \
	case $$extension in \
		sh|bash|py|tf) comment="#";; \
		go) comment="//";; \
		*) echo "Unsupported file extension: [$$extension]"; exit 1;; \
	esac; \
	if ! head -n 10 $$file_path | grep -q "MIT License"; then \
		tmp_file=$$(mktemp); \
		{ \
			read -r first_line < $$file_path; \
			if echo "$$first_line" | grep -q '^#!'; then \
				echo "$$first_line" > $$tmp_file; \
				while IFS= read -r line; do \
					if [ -z "$$line" ]; then \
						echo "$$comment"; \
					else \
						echo "$$comment $$line"; \
					fi; \
				done < LICENSE >> $$tmp_file; \
				echo "" >> $$tmp_file; \
				tail -n +2 $$file_path >> $$tmp_file; \
			else \
				while IFS= read -r line; do \
					if [ -z "$$line" ]; then \
						echo "$$comment"; \
					else \
						echo "$$comment $$line"; \
					fi; \
				done < LICENSE > $$tmp_file; \
				echo "" >> $$tmp_file; \
				cat $$file_path >> $$tmp_file; \
			fi; \
		} && mv $$tmp_file $$file_path; \
		echo "License added to [$$file_path]"; \
	else \
		echo "License already present in [$$file_path]"; \
	fi;
endef

license:
	$(call add_license)

help:
	@echo "Usage:"
	@echo "  make license file=path/to/your/file    Add license header to the specified file"
	@echo "  make help                              Show this help message"

