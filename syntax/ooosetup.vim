" Vim syntax file
" Language:     OpenOffice.org 1.x/StarOffice 5.2,6.x,7.x setup response file
" Maintainer:   Olivier Mengué <NO.dol.SP.men.AM@NOSPAM.openoffice.org>
" Last Change:  2004 Oct 27
" Copyright:	(c) 2004 Olivier Mengué
" See:		http://installation.openoffice.org/01RESPONSE_SO52_final_rev2.pdf


" Standard header: exit if already done {{{1
" For version 5.x: Quit
" For version 6.x: Quit when a syntax file was already loaded
if version < 600 || exists("b:current_syntax")
  finish
endif

" Include vb syntax {{{1
syn include @ooosetupVB syntax/vb.vim

syn case ignore



" Error {{{1
syn match   ooosetupError =\S.*= excludenl

" Comments {{{1
syn match   ooosetupCopyright contained +Copyright\s.*$+ excludenl
syn keyword ooosetupTodo contained TODO FIXME
syn match   ooosetupComment =^\s*REM\s.*$= excludenl contains=ooosetupCopyright,ooosetupCommentTitle,ooosetupTodo,@ooosetupCommentHook
syn match   ooosetupComment =^\s*REM$= excludenl
syn match   ooosetupCommentTitle =REM\s\+\u\w*\(\s\+\u\w*\)*:=hs=s+4 contained contains=ooosetupCommentTitleLeader
syn match   ooosetupCommentTitleLeader =REM\s\+=ms=s+3 contained

" Various {{{1
syn match   ooosetupSection  =^\[\w\+\]= contained contains=ooosetupSpecial
syn match   ooosetupSpecial  +[][=,]+ contained
syn match   ooosetupKnownKey =\w\+= contained
syn match   ooosetupBool '=\(YES\|NO\|TRUE\|FALSE\)'hs=s+1 contained contains=ooosetupSpecial
syn match   ooosetupNumber '=\d\+'hs=s+1 contained contains=ooosetupSpecial
syn match   ooosetupProc '=\w\+'hs=s+1 contained contains=ooosetupSpecial
syn match   ooosetupPathSpecial '=<\(firstfree\|home\)>'hs=s+1 contained contains=ooosetupSpecial
syn match   ooosetupPathError '[<>]' contained
syn match   ooosetupPath '=.\+'hs=s+1 contained contains=ooosetupSpecial,ooosetupPathError,ooosetupPathSpecial

" [Environment] section {{{1
syn region  ooosetupEnvironmentSection start=+^\[Environment\]+ end=+^\[+me=e-1 transparent keepend contains=ooosetupError,ooosetupComment,ooosetupEnvMode,ooosetupEnvType,ooosetupEnvMigration,ooosetupEnvPath,ooosetupEnvLang,ooosetupEnvProc,ooosetupSection
syn match   ooosetupEnvMode +^\s*InstallationMode+ contained contains=ooosetupKnownKey nextgroup=ooosetupEnvModeValue
syn match   ooosetupEnvModeValue '=\(Install_\(Normal\|Network\|Workstation\)\|Repair\|\(Re\|De\)install\)'hs=s+1 contained contains=ooosetupSpecial
syn match   ooosetupEnvType +^\s*InstallationType+ contained contains=ooosetupKnownKey nextgroup=ooosetupEnvTypeValue
syn match   ooosetupEnvTypeValue '=\(Standard\|Specify\|Minimum\|Workstation\)'hs=s+1 contained contains=ooosetupSpecial
syn match   ooosetupEnvMigration +^\s*Migration+ contained contains=ooosetupKnownKey nextgroup=ooosetupBool
syn match   ooosetupEnvPath +^\s*DestinationPath+ contained contains=ooosetupKnownKey nextgroup=ooosetupPath
" Number or Number list (separated by comma ?)
syn match   ooosetupEnvLang +^\s*LanguageList+ contained contains=ooosetupKnownKey nextgroup=ooosetupNumber
syn match   ooosetupEnvProc +^\s*\(Start\|End\)Procedure+ contained contains=ooosetupKnownKey nextgroup=ooosetupProc

" [Module_Specify] section {{{1
syn region  ooosetupModuleSpecifySection start=+^\[Module_Specify\]+ end=+^\[+me=e-1 transparent keepend contains=ooosetupError,ooosetupComment,ooosetupModuleSet,ooosetupModuleInst,ooosetupSection
" TODO Improve this (requires to test the setup)
"syn match   ooosetupModuleSet "^\s*[^,=]\+\s*=\(\s*gid_Module_\w\+\s*\)\(,\s*gid_Module_\w\+\s*\)*" contained contains=ooosetupSpecial
syn match   ooosetupModuleSet "^\s*[^,=]\+\s*=\(\s*[^,]\+\s*\)\(,\s*[^,]\+\s*\)*" contained contains=ooosetupSpecial
syn match   ooosetupModuleInst +^\s*\(De\)\?Install\(Procedure\|ModuleSet\)+ contained contains=ooosetupKnownKey nextgroup=ooosetupProc


" [Windows_Desktop_Integration] section {{{1
syn region  ooosetupWDISection start=+^\[Windows_Desktop_Integration\]+ end=+^\[+me=e-1 transparent keepend contains=ooosetupError,ooosetupComment,ooosetupWDIRegister,ooosetupSection
syn match   ooosetupWDIRegister +^\s*Register\(AsDefaultHtmlEditor\|ForMs\(Word\|Excel\|PowerPoint\)\)+ contained contains=ooosetupKnownKey nextgroup=ooosetupBool

" [Java] section {{{1
syn region  ooosetupJavaSection start=+^\[Java\]+ end=+^\[+me=e-1 transparent keepend contains=ooosetupError,ooosetupComment,ooosetupJavaSupport,ooosetupSection
syn match   ooosetupJavaSupport +^\s*JavaSupport+ contained contains=ooosetupKnownKey nextgroup=ooosetupJavaSupportValue
syn match   ooosetupJavaSupportValue '=\(None\|Preinstalled_or_None\|NewInstall\)'hs=s+1 contained contains=ooosetupSpecial

" [Procedures] section {{{1
syn region  ooosetupProceduresSection start=+^\[Procedures\]+ end=+^\[+me=e-1 transparent keepend contains=@ooosetupVB,ooosetupComment,ooosetupProceduresHeader

syn match   ooosetupProceduresHeader +^\[Procedures\].*$+ contained contains=ooosetupError,ooosetupSection nextgroup=@ooosetupVB,ooosetupComment

syn keyword vbFunction DirEntry 
syn keyword vbFunction SetUserFirstName SetUserLastName SetUserID SetUserEMail
syn keyword vbFunction SetUserStreet SetUserZip SetUserCity SetUserCompanyName
syn keyword vbFunction ShowSetup HideSetup DefUseRestart GetSetupEnv
syn keyword vbFunction SelectModuleSet DeSelectModuleSet

" Sync {{{1
" TODO fix this. I don't really understand how syn-sync-match works
syn sync clear
"syn cluster ooosetupAllSections contains=ooosetupEnvironmentSection,ooosetupModuleSpecifySection,ooosetupWDISection,ooosetupJavaSection,ooosetupProceduresSection
syn sync match ooosetupSyncSections groupthere NONE +^\[+me=s


" Default highlighting {{{1

hi def link ooosetupError		Error

hi def link ooosetupComment		Comment
hi def link ooosetupCommentTitle	PreProc
hi def link ooosetupCopyright		ooosetupComment
hi def link ooosetupTodo		Todo

hi def link ooosetupSection		Keyword
hi def link ooosetupSpecial		Special
hi def link ooosetupKnownKey		Keyword
hi def link ooosetupBool		ooosetupConstant
hi def link ooosetupNumber		ooosetupConstant
hi def link ooosetupEnvModeValue	ooosetupConstant
hi def link ooosetupEnvTypeValue	ooosetupConstant
hi def link ooosetupJavaSupportValue	ooosetupConstant
hi def link ooosetupPath		ooosetupConstant
hi def link ooosetupProc		ooosetupIdentifier
hi def link ooosetupPathSpecial		PreProc
hi def link ooosetupPathError		ooosetupError
hi def link ooosetupModuleSet		ooosetupIdentifier

hi def link ooosetupConstant		Constant
hi def link ooosetupIdentifier		Identifier

" }}}1

let b:current_syntax = "ooosetup"

" vim: ts=8 sw=2 fdm=marker
