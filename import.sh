#!/usr/bin/env bash
source .env
md2hugo -genCate -genKeys -genTags -vaultDir=$vaultDir -exportDirs=$exportDirs -hugoDir=$hugoDir
