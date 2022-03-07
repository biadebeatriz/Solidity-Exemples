
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IERC20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract LP {
 
    address public tokenA;
    address public tokenB;
    address public owner;   
    address private constant ROUTER = 0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506; 
    uint private min = 1;
    IUniswapV2Router02 public uniswapV2Router;
    uint256 public balanceA;
    uint256 public balanceB;
    uint256 public balanceThisA;
    uint256 public balanceThisB;
    uint public allowA;
    uint public allowB;
    uint public allowBthis;
    uint public allowAthis;



    event Add(string message, uint val);
    event Trans(string message, uint val);
    event Addr(address addr);

    constructor(address _tokenA, address _tokenB) {
        tokenA = address(_tokenA);
        tokenB = address(_tokenB);
        owner = msg.sender;        
        uniswapV2Router = IUniswapV2Router02(ROUTER);       
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "not owner");
        _;
    }


    function setOwner(address _newOwner) external onlyOwner{
        require( _newOwner != address(0),"invalid address");
        owner = _newOwner;
    }
    function approve() external{
        IERC20(tokenA).approve(owner,balanceA);
        IERC20(tokenB).approve(owner,balanceB);
        IERC20(tokenA).approve(address(this), balanceA);
        IERC20(tokenB).approve(address(this), balanceB);
    }
    function allow() external {
        allowA = IERC20(tokenA).allowance(msg.sender, owner);
        allowB = IERC20(tokenA).allowance(msg.sender, owner);
        allowAthis = IERC20(tokenA).allowance(msg.sender, address(this));
        allowBthis = IERC20(tokenA).allowance(msg.sender, address(this));

    }


    function transfer() external {

        IERC20(tokenA).transfer(address(this), balanceA);
        IERC20(tokenB).transfer(address(this), balanceB);
    }

    function balance() external {
        balanceA = IERC20(tokenA).balanceOf(owner);
        balanceB = IERC20(tokenB).balanceOf(owner);
    }

    function balancethis() external{
        balanceThisA = IERC20(tokenA).balanceOf(address(this));
        balanceThisB = IERC20(tokenB).balanceOf(address(this));
    }

    function add() external onlyOwner {  

        uint256 balanceOfA = IERC20(tokenA).balanceOf(address(this));
        uint256 balanceOfB = IERC20(tokenB).balanceOf(address(this));
        require(balanceOfA > 0, "don't have enough TokenA");
        require(balanceOfB > 0, "don't have enough TokenB");
        require(IERC20(tokenA).approve(ROUTER, balanceOfA), "approval to router use tokenA failed");
        require(IERC20(tokenB).approve(ROUTER, balanceOfB), "approval to router use tokenA failed");
        require(IERC20(tokenB).allowance(address(this), ROUTER) >= balanceOfB, "don't have enough allowance to Router for TokenB");
        require(IERC20(tokenA).allowance(address(this), ROUTER) >= balanceOfA, "don't have enough allowance to Router for TokenA");

        (uint256 amountA, uint256 amountB, uint256 liquidity) = uniswapV2Router.addLiquidity(
            tokenA,
            tokenB,
            balanceOfA,
            balanceOfB,
            min,
            min,
            address(this),
            block.timestamp
        );
        emit Add("amountA", amountA);
        emit Add("amountB", amountB);
        emit Add("liquidity", liquidity);
        emit Addr(address(this));
    }


    function Transfer(address addr) external onlyOwner{
        address pair = IUniswapV2Factory(uniswapV2Router.factory()).getPair(tokenA,tokenB);
        //get the balances of liquidity tokens that this contract has
        uint256 _liquidity = IERC20(pair).balanceOf(address(this)); 
        
        IERC20(pair).approve(ROUTER, _liquidity);
        (uint amountA, uint amountB)=
        IUniswapV2Router01(ROUTER).removeLiquidity(
            tokenA,
            tokenB,
            _liquidity,
            min,
            min,
            addr,
            block.timestamp
        );
        emit Trans("amountA", amountA);
        emit Trans("amoubtB", amountB);
    }


}