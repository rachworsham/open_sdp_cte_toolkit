// Change the path in the next line to your top-level working directory
cd "your filepath"
global file "your filepath"

// converting files from .do to .md
	webdoc do "$file/code/cte_toolkit_narrative_webdoc.do", cmdlog nodo nologall 
	webdoc strip "$file/code/cte_toolkit_narrative_webdoc.do" "$file/code/cte_toolkit_narrative.do", replace
	
	webdoc do "$file/code/cte_toolkit_technicalguide_webdoc.do", cmdlog nodo nologall 
	webdoc strip "$file/code/cte_toolkit_technicalguide_webdoc.do" "$file/code/cte_toolkit_technicalguide.do", replace

// Convert markdown to html

	markdown "./docs/open_sdp_cte_toolkit/docs.md", saving("$file/docs/open_sdp_cte_toolkit/cte_toolkit_narrative.html") replace
	
	markdown "./docs/open_sdp_cte_toolkit/docs.md", saving("$file/docs/open_sdp_cte_toolkit/cte_toolkit_technicalguide.html") replace
	
// see here for help: https://www.ssc.wisc.edu/~hemken/Stataworkshops/dyndoc%20review/Review.html
