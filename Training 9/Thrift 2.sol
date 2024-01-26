//solidity
 struct Club{
        string clubName;
    }
    struct Users{
     
        string userName;
        address userAddress;  
    }
   
    Users[] Public;
   


    mapping(string =>  Users[]) Public clubtouser;
    mapping(string => uint256) public nameToAmount;
    mapping(string => uint256) public numberOfUsers;
    mapping(address => bool) public hasPaid;
    mapping(string => uint256 ) public totalAmountInClub;
    mapping(string => uint256) public trackOfUsersThatPaid;
      uint32 public randomness;
      uint time ;
    uint256 public latestRandomizingBlock;
    IWitnetRandomness immutable public witnet;
   

    constructor (IWitnetRandomness _witnetRandomness) {
        assert(address(_witnetRandomness) != address(0));
        witnet = _witnetRandomness;
 time = block.timestamp;
    }
// desired name and username 
    function createClub(string memory _clubName, string memory _userName) public{      
        Users memory clubUser =  Users(_userName, msg.sender);
         numberOfUsers[_clubName] = 1;
        clubToUser[_clubName].push(clubUser);   
    }
// valid club name 
string memory _clubName , string memory _userName, address _user

function addUser(string memory _clubName , string memory _userName, address _user) public{
        require(clubToUser[_clubName].length>0, "Club Not Found");
        Users memory clubUser = Users(_userName, _user);
         numberOfUsers[_clubName] += 1;
        clubToUser[_clubName].push(clubUser);
       
    }
//function for contribution 
 function proposedContirbutionAmount(string memory _clubName, uint256 _proposedAmount)

 function proposedContirbutionAmount(string memory _clubName, uint256 _proposedAmount) public {
     uint256 amountInEther= _proposedAmount*10**18;
     nameToAmount[_clubName] = amountInEther;

    }

    //function for balance and how much the account holds 
function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    function getAmountFromClub(string memory _clubName) public view returns(uint256){
        return nameToAmount[_clubName];
    }