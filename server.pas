Program server;

{
  Program to test Sockets unit by Michael van Canneyt and Peter Vreman
  Server Version, First Run sock_svr to let it create a socket and then
  sock_cli to connect to that socket
}
{$mode fpc}
uses Sockets,Sysutils;

Var
  FromName : string;
  Buffer   : string[255];
  S        : Longint;
  Sin,Sout : Text;
  SAddr    : TInetSockAddr;
  f2       : TextFile;

procedure perror (const S:string);
begin
  writeln (S,SocketError);
  halt(100);
end;

begin
  Assign(f2, 'teste2');
  S:=fpSocket (AF_INET,SOCK_STREAM,0);
  if SocketError<>0 then
   Perror ('Server : Socket : ');
  SAddr.sin_family:=AF_INET;
  { port 50000 in network order }
  SAddr.sin_port:=htons(5000);
  SAddr.sin_addr.s_addr:=HostToNet((127 shl 24) or 1);
  if fpBind(S,@SAddr,sizeof(saddr))=-1 then
   PError ('Server : Bind : ');
  if fpListen (S,1)=-1 then
   PError ('Server : Listen : ');
  Writeln('Waiting for Connect from Client, run now sock_cli in an other tty');
  if not Accept(S,FromName,Sin,Sout) then
   PError ('Server : Accept : '+fromname);
  Reset(Sin);
  rewrite(f2);
  while not eof(sin) do
   begin
     Readln(Sin,Buffer);
     Writeln(f2, Buffer);
   end;
   close(f2);
end.