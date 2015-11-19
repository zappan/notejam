<?php


namespace App\Helpers;


class OrderHelper
{

	/**
	 * Translates order parameter from URL to array usable for sorting a Nette Database Selection.
	 * @param string $orderBy
	 * @return string
	 */
	public static function translateParameterToColumns($orderBy)
	{
		return
			[
				'name'        => 'name ASC',
				'-name'       => 'name DESC',
				'updated_at'  => 'updated_at ASC',
				'-updated_at' => 'updated_at DESC'
			][$orderBy];
	}

}
