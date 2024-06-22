.DEFAULT_GOAL := help

.PHONY: help license memo music

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

# Function to add a memo to the git history
define add_memo_commit
    @read -p "Memo: " memo; \
	git commit --allow-empty -m "[Memo] $$memo"; \
	echo "Added memo to git history"
endef

# Function to add a music commit
define add_music_commit
	@read -p "Track title: " title; \
	read -p "Artist: " artist; \
	read -p "Spotify URL: " url; \
	git commit --allow-empty -m "[Music] $$title, $$artist, $$url"; \
	echo "Song entry created in git history"
endef

memo:
	$(call add_memo_commit)

music:
	$(call add_music_commit)

license:
	$(call add_license)

help:
	@echo "Usage:"
	@echo "  make help                              Show this help message"
	@echo "  make license file=path/to/your/file    Add license header to the specified file"
	@echo "  make memo                              Add a memo to the git history"
	@echo "  make music                             Prompt for song information and add to git history"

