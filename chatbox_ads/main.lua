
local adMessages = { }

addEventHandler( "onResourceStart", getResourceRootElement( getThisResource( ) ),
    function()
        local msg
        local file_root = xmlLoadFile( "ads.xml" )
        if file_root then
            local ads = 0
            local ad_node = xmlFindSubNode( file_root, "ad", 0 )
            if ad_node then
                while ad_node do
                    ads = ads + 1
                    adMessages[ ads ] = xmlNodeGetValue( ad_node )
                    ad_node = xmlFindSubNode( file_root, "ad", ads )
                end
                msg = "SUCCESS: advertisement messages loaded - "..tostring( ads ).." message(s)"
                outputServerLog( msg )
                outputDebugString( msg )
                setTimer( advert, 1 * 30000, 0 )
            else
                msg = "WARNING: file ads.xml does not contain any advertisement messages"
                outputServerLog( msg )
                outputDebugString( msg )
            end
            xmlUnloadFile( file_root )
        else
            msg = "ERROR: file ads.xml couldn't be loaded"
            outputServerLog( msg )
            outputDebugString( msg )
        end
    end
)

addEventHandler( "onPlayerJoin", getRootElement( ),
    function( )
        local rnd = math.random( 1, #adMessages )
        outputTopChat( adMessages[ rnd ], source, 255,255,255, true )
    end
)

function advert( )
    local rnd = math.random( 1, #adMessages )
    outputTopChat( adMessages[ rnd ], getRootElement(), 255, 255, 255, true )
end


