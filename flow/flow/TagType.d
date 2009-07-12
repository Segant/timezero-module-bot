module flow.TagType;

public enum TagType : uint {
	END								= 0,  /* end tag for movie clip or swf */
	SHOWFRAME						= 1,  /* frame is completely described now, please show */
	DEFINESHAPE						= 2,
	FREECHARACTER					= 3,
	PLACEOBJECT						= 4,
	REMOVEOBJECT					= 5,
	DEFINEBITS						= 6,
	DEFINEBUTTON					= 7,
	JPEGTABLES						= 8,
	SETBACKGROUNDCOLOR				= 9,
	DEFINEFONT						= 10,
	DEFINETEXT						= 11,
	DOACTION						= 12, /* normal action block */
	DEFINEFONTINFO					= 13,
	DEFINESOUND						= 14,
	STARTSOUND						= 15,
	STOPSOUND						= 16,
	DEFINEBUTTONSOUND				= 17,
	SOUNDSTREAMHEAD					= 18,
	SOUNDSTREAMBLOCK				= 19,
	DEFINEBITSLOSSLESS				= 20,
	DEFINEBITSJPEG2					= 21,
	DEFINESHAPE2					= 22,
	DEFINEBUTTONCXFORM				= 23,
	PROTECT							= 24, /* the author doesn't want the file to be opened */
	PATHSAREPOSTSCRIPT				= 25,
	PLACEOBJECT2					= 26, /* possibly onClipEvents inside */
	REMOVEOBJECT2					= 28,
	SYNCFRAME						= 29,
	FREEALL							= 31,
	DEFINESHAPE3					= 32,
	DEFINETEXT2						= 33,
	DEFINEBUTTON2					= 34, /* possibly button events inside */
	DEFINEBITSJPEG3					= 35,
	DEFINEBITSLOSSLESS2				= 36,
	DEFINEEDITTEXT					= 37,
	DEFINEVIDEO						= 38,
	DEFINEMOVIECLIP					= 39, /* movie clip timeline comes */
	NAMECHARACTER					= 40,
	SERIALNUMBER					= 41,
	DEFINETEXTFORMAT				= 42,
	FRAMELABEL						= 43,
	SOUNDSTREAMHEAD2				= 45,
	DEFINEMORPHSHAPE				= 46,
	GENFRAME						= 47,
	DEFINEFONT2						= 48,
	GENCOMMAND						= 49,
	DEFINECOMMANDOBJ				= 50,
	CHARACTERSET					= 51,
	FONTREF							= 52,
	EXPORTASSETS					= 56,
	IMPORTASSETS					= 57,
	ENABLEDEBUGGER					= 58,
	INITMOVIECLIP					= 59, /* flash 6 mc initialization actions (#initclip .. #endinitclip) */
	DEFINEVIDEOSTREAM				= 60,
	VIDEOFRAME						= 61,
	DEFINEFONTINFO2					= 62,
	DEBUGID							= 63,
	ENABLEDEBUGGER2					= 64,
	SCRIPTLIMITS					= 65,
	SETTABINDEX						= 66,
	DEFINESHAPE4					= 67,
	FILEATTRIBUTES					= 69,
	PLACEOBJECT3					= 70, /* possibly onClipEvents inside */
	IMPORTASSETS2					= 71,
	DEFINEFONTINFO3					= 73,
	DEFINETEXTINFO					= 74,
	DEFINEFONT3						= 75,
	AVM2DECL						= 76,
	METADATA						= 77,
	SLICE9							= 78,
	AVM2ACTION						= 82,
	DEFINESHAPE5					= 83,
	DEFINEMORPHSHAPE2				= 84,
	DEFINEBITSPTR					= 1023
};

char[] getTagString(uint tag)
{
	switch(tag) {
		case TagType.END:					return "END";
		case TagType.SHOWFRAME:				return "SHOWFRAME";
		case TagType.DEFINESHAPE:			return "DEFINESHAPE";
		case TagType.FREECHARACTER:			return "FREECHARACTER";
		case TagType.PLACEOBJECT:			return "PLACEOBJECT";
		case TagType.REMOVEOBJECT:			return "REMOVEOBJECT";
		case TagType.DEFINEBITS:			return "DEFINEBITS";
		case TagType.DEFINEBUTTON:			return "DEFINEBUTTON";
		case TagType.JPEGTABLES:			return "JPEGTABLES";
		case TagType.SETBACKGROUNDCOLOR:	return "SETBACKGROUNDCOLOR";
		case TagType.DEFINEFONT:			return "DEFINEFONT";
		case TagType.DEFINETEXT:			return "DEFINETEXT";
		case TagType.DOACTION:				return "DOACTION";
		case TagType.DEFINEFONTINFO:		return "DEFINEFONTINFO";
		case TagType.DEFINESOUND:			return "DEFINESOUND";
		case TagType.STARTSOUND:			return "STARTSOUND";
		case TagType.STOPSOUND:				return "STOPSOUND";
		case TagType.DEFINEBUTTONSOUND:		return "DEFINEBUTTONSOUND";
		case TagType.SOUNDSTREAMHEAD:		return "SOUNDSTREAMHEAD";
		case TagType.SOUNDSTREAMBLOCK:		return "SOUNDSTREAMBLOCK";
		case TagType.DEFINEBITSLOSSLESS:	return "DEFINEBITSLOSSLESS";
		case TagType.DEFINEBITSJPEG2:		return "DEFINEBITSJPEG2";
		case TagType.DEFINESHAPE2:			return "DEFINESHAPE2";
		case TagType.DEFINEBUTTONCXFORM:	return "DEFINEBUTTONCXFORM";
		case TagType.PROTECT:				return "PROTECT";
		case TagType.PATHSAREPOSTSCRIPT:	return "PATHSAREPOSTSCRIPT";
		case TagType.PLACEOBJECT2:			return "PLACEOBJECT2";
		case TagType.REMOVEOBJECT2:			return "REMOVEOBJECT2";
		case TagType.SYNCFRAME:				return "SYNCFRAME";
		case TagType.FREEALL:				return "FREEALL";
		case TagType.DEFINESHAPE3:			return "DEFINESHAPE3";
		case TagType.DEFINETEXT2:			return "DEFINETEXT2";
		case TagType.DEFINEBUTTON2:			return "DEFINEBUTTON2";
		case TagType.DEFINEBITSJPEG3:		return "DEFINEBITSJPEG3";
		case TagType.DEFINEBITSLOSSLESS2:	return "DEFINEBITSLOSSLESS2";
		case TagType.DEFINEEDITTEXT:		return "DEFINEEDITTEXT";
		case TagType.DEFINEVIDEO:			return "DEFINEVIDEO";
		case TagType.DEFINEMOVIECLIP:		return "DEFINEMOVIECLIP";
		case TagType.NAMECHARACTER:			return "NAMECHARACTER";
		case TagType.SERIALNUMBER:			return "SERIALNUMBER";
		case TagType.DEFINETEXTFORMAT:		return "DEFINETEXTFORMAT";
		case TagType.FRAMELABEL:			return "FRAMELABEL";
		case TagType.SOUNDSTREAMHEAD2:		return "SOUNDSTREAMHEAD2";
		case TagType.DEFINEMORPHSHAPE:		return "DEFINEMORPHSHAPE";
		case TagType.GENFRAME:				return "GENFRAME";
		case TagType.DEFINEFONT2:			return "DEFINEFONT2";
		case TagType.GENCOMMAND:			return "GENCOMMAND";
		case TagType.DEFINECOMMANDOBJ:		return "DEFINECOMMANDOBJ";
		case TagType.CHARACTERSET:			return "CHARACTERSET";
		case TagType.FONTREF:				return "FONTREF";
		case TagType.EXPORTASSETS:			return "EXPORTASSETS";
		case TagType.IMPORTASSETS:			return "IMPORTASSETS";
		case TagType.ENABLEDEBUGGER:		return "ENABLEDEBUGGER";
		case TagType.INITMOVIECLIP:			return "INITMOVIECLIP";
		case TagType.DEFINEVIDEOSTREAM:		return "DEFINEVIDEOSTREAM";
		case TagType.VIDEOFRAME:			return "VIDEOFRAME";
		case TagType.DEFINEFONTINFO2:		return "DEFINEFONTINFO2";
		case TagType.ENABLEDEBUGGER2:		return "ENABLEDEBUGGER2";
		case TagType.SCRIPTLIMITS:			return "SCRIPTLIMITS";
		case TagType.SETTABINDEX:			return "SETTABINDEX";
		case TagType.DEFINESHAPE4:			return "DEFINESHAPE4";
		case TagType.FILEATTRIBUTES:		return "FILEATTRIBUTES";
		case TagType.PLACEOBJECT3:			return "PLACEOBJECT3";
		case TagType.IMPORTASSETS2:			return "IMPORTASSETS2";
		case TagType.DEFINEFONTINFO3:		return "DEFINEFONTINFO3";
		case TagType.DEFINETEXTINFO:		return "DEFINETEXTINFO";
		case TagType.DEFINEFONT3:			return "DEFINEFONT3";
		case TagType.METADATA:				return "METADATA";
		case TagType.SLICE9:				return "SLICE9";
		case TagType.DEFINESHAPE5:			return "DEFINESHAPE5";
		case TagType.DEFINEMORPHSHAPE2:	    return "DEFINEMORPHSHAPE2";
		case TagType.DEFINEBITSPTR:         return "DEFINEBITSPTR";
		default:
			return "Unknown tag";
	}
}