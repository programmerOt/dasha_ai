import "commonReactions/all.dsl";

context {
    input phone: string;
}

start node root
{
    do
    {
        #connectSafe($phone);
        #waitForSpeech(1200);
        #say("greeting");
        #waitingMode(1200);
        #say("offer");
        #waitingMode(1000);
        #say("offer1");
        #waitingMode(1000);
        #say("question");
        wait *;
    }
    transitions
    {
        
        interest: goto interest on #messageHasIntent("interest");
        nointerest: goto nointerest on #messageHasIntent("nointerest");
        when_callback: goto when_callback on #messageHasIntent("when_callback");
       
    }
}

node interest
{
    do
    {
        #say("interest");
        wait*;
    }
    transitions
    {
        connection: goto connection on #messageHasIntent("connection");
        // when_comfort: goto connection on #messageHasIntent("when_callback");
        
    }
}
node nointerest
{
    do
    {
        #say("nointerest");
        wait*;
    }
    transitions
    {
        effective: goto effective on #messageHasIntent("effective");
    }
}
node effective
{
    do
    {
        #say("effective");
        wait*;
    }
    transitions
    {
        load: goto load on #messageHasIntent("load");
        dontwant: goto dontwant on #messageHasIntent("dontwant");
    }
}
node when_callback
{
    do
    {
        #say("when_callback");
         wait*;
    }

    transitions
    {
        great: goto great on #messageHasIntent("great");
    }
}
node great{
    do{
        #say("great");
        #say("connection");
         wait*;
    }
    
}
node connection{
    do{
        #say("connection");
        #disconnect();
        
    }
    transitions{
    }
}

   

node load{
    do{
        #say("load");
        wait*;
    }
    transitions{
     interest: goto interest on #messageHasIntent("interest");
     nointerest: goto nointerest on #messageHasIntent("nointerest");
    }
}
node dontwant{
    do{
        #say("dontwant");
        #disconnect();
    }
}