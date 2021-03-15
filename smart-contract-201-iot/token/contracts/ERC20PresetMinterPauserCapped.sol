// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

import "./AccessControl.sol";
import "./Context.sol";
import "./ERC20.sol";
import "./ERC20Burnable.sol";
import "./SafeMath.sol";
import "./ERC20Pausable.sol";

/**
 * @dev {ERC20} token, including:
 *
 *  - ability for holders to burn (destroy) their tokens
 *  - a minter role that allows for token minting (creation)
 *  - a pauser role that allows to stop all token transfers
 *
 * This contract uses {AccessControl} to lock permissioned functions using the
 * different roles - head to its documentation for details.
 *
 * The account that deploys the contract will be granted the minter and pauser
 * roles, as well as the default admin role, which will let it grant both minter
 * and pauser roles to other accounts.
 */
contract ERC20PresetMinterPauser is Context, AccessControl, ERC20Burnable, ERC20Pausable {
    
    using SafeMath for uint256;
    uint256 private _cap;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant CAP_ROLE = keccak256("CAP_ROLE");

    /**
     * @dev Grants `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
     * account that deploys the contract.
     *
     * See {ERC20-constructor}.
     */
    constructor(string memory name, string memory symbol, uint256 cap_) public ERC20(name, symbol) {
        require(cap_ > 0, "ERC20MinterPauserCapped: Cap is 0");

        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
        _setupRole(PAUSER_ROLE, _msgSender());
        _setupRole(CAP_ROLE, _msgSender());

        _cap = cap_;
    }

    /**
     * @dev Creates `amount` new tokens for `to`.
     *
     * See {ERC20-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(address to, uint256 amount) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "ERC20MinterPauserCapped: must have minter role to mint");
        _mint(to, amount);
    }

    /**
     * @dev Pauses all token transfers.
     *
     * See {ERC20Pausable} and {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ERC20MinterPauserCapped: must have pauser role to pause");
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     *
     * See {ERC20Pausable} and {Pausable-_unpause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ERC20MinterPauserCapped: must have pauser role to unpause");
        _unpause();
    }

    /**
     * @dev Modifies the maximum supply of the token
     *
     * Requirements:
     *
     * - the caller must have the `CAP_ROLE`.
     */

    function changeCap(uint256 newCap_) public virtual {
        require(hasRole(CAP_ROLE, _msgSender()), "ERC20MinterPauserCapped: must have cap role to modify maximum supply");
        // Make sure that the total supply will not exceed the new cap
        require(totalSupply() >= newCap, "ERC20MinterPauserCapped: cap exceeded");
        _cap = newCap_;
    }

    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);

        if (from == address(0)) { // When minting tokens
            require(totalSupply().add(amount) <= cap(), "ERC20MinterPauserCapped: cap exceeded");
        }
    }
}
